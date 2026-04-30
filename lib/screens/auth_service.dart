import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/trip_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  String? get currentUid => _auth.currentUser?.uid;

  // ── Sign Up ───────────────────────────────────────────────────────
  Future<String> signUpUser({
    required String firstname,
    required String lastname,
    required String username,
    required String email,
    required String password,
    required String date,
    required String phonenumber,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _firestore.collection("users").doc(credential.user!.uid).set({
          'firstname': firstname,
          'lastname': lastname,
          'username': username,
          'email': email,
          'phonenumber': phonenumber,
          'date': date,
          'uid': credential.user!.uid,
          'createdAt': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please fill all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // ── Login ─────────────────────────────────────────────────────────
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // ── Get current user data ─────────────────────────────────────────
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final uid = currentUid;
      if (uid == null) return null;

      // try 'users' collection first
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) return doc.data();

      // fallback: try 'userData' collection (old accounts)
      final doc2 = await _firestore.collection('userData').doc(uid).get();
      if (doc2.exists && doc2.data() != null) return doc2.data();

      return null;
    } catch (_) {
      return null;
    }
  }


  // ── Send message ──────────────────────────────────────────────────
Future<void> sendMessage({
  required String chatId,
  required String text,
}) async {
  final uid = currentUid;
  if (uid == null) return;
  await _firestore
      .collection('chats')
      .doc(chatId)
      .collection('messages')
      .add({
    'senderId': uid,
    'text': text,
    'timestamp': FieldValue.serverTimestamp(),
  });
  // update last message on chat doc
  await _firestore.collection('chats').doc(chatId).set({
    'lastMessage': text,
    'lastTimestamp': FieldValue.serverTimestamp(),
    'participants': [uid],
  }, SetOptions(merge: true));
}

// ── Get messages stream ───────────────────────────────────────────
Stream<QuerySnapshot> getMessagesStream(String chatId) {
  return _firestore
      .collection('chats')
      .doc(chatId)
      .collection('messages')
      .orderBy('timestamp', descending: false)
      .snapshots();
}

// ── Get chats stream ──────────────────────────────────────────────
Stream<QuerySnapshot> getChatsStream() {
  final uid = currentUid;
  if (uid == null) return const Stream.empty();
  return _firestore
      .collection('chats')
      .where('participants', arrayContains: uid)
      .orderBy('lastTimestamp', descending: true)
      .snapshots();
}

// ── Create or get chat ID between two users ───────────────────────
String getChatId(String otherUid) {
  final uid = currentUid ?? '';
  final ids = [uid, otherUid]..sort();
  return ids.join('_');
}

  // ── Save trip ─────────────────────────────────────────────────────
  Future<String> saveTrip(TripModel trip, {
    required String fromCode,
    required String fromCity,
    required String toCode,
    required String toCity,
    required String departureDate,
    required String flightNumber,
    required String luggageSpace,
    required String pricePerKg,
  }) async {
    try {
      final uid = currentUid;
      if (uid == null) return 'Not logged in';

      final userData = await getUserData();
      final first = (userData?['firstname'] ?? '').toString().trim();
      final last  = (userData?['lastname']  ?? '').toString().trim();
      final name  = '$first $last'.trim();

      await _firestore.collection('trips').add({
        'uid': uid,
        'travelerName': name.isEmpty ? 'Unknown' : name,
        'fromCode': fromCode,
        'fromCity': fromCity,
        'toCode': toCode,
        'toCity': toCity,
        'departureDate': departureDate,
        'flightNumber': flightNumber,
        'luggageSpace': luggageSpace,
        'pricePerKg': pricePerKg,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return 'success';
    } catch (err) {
      return err.toString();
    }
  }

  // ── Save parcel ───────────────────────────────────────────────────
  Future<String> saveParcel({
    required String pickupLocation,
    required String destination,
    required String packageType,
    required String weight,
    required String description,
    required String deadline,
    required String deliveryType,
    required String receiverName,
    required String price,
  }) async {
    try {
      final uid = currentUid;
      if (uid == null) return 'Not logged in';

      final userData = await getUserData();
      final first = (userData?['firstname'] ?? '').toString().trim();
      final last  = (userData?['lastname']  ?? '').toString().trim();
      final name  = '$first $last'.trim();

      await _firestore.collection('parcels').add({
        'uid': uid,
        'senderName': name.isEmpty ? 'Unknown' : name,
        'pickupLocation': pickupLocation,
        'destination': destination,
        'packageType': packageType,
        'weight': weight,
        'description': description,
        'deadline': deadline,
        'deliveryType': deliveryType,
        'receiverName': receiverName,
        'price': price,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return 'success';
    } catch (err) {
      return err.toString();
    }
  }

  // ── Get trips ─────────────────────────────────────────────────────
  Future<List<Map<String, dynamic>>> getTrips({
    String? fromCity,
    String? toCity,
  }) async {
    try {
      Query query = _firestore.collection('trips');
      if (fromCity != null && fromCity.isNotEmpty) {
        query = query.where('fromCity', isEqualTo: fromCity);
      }
      if (toCity != null && toCity.isNotEmpty) {
        query = query.where('toCity', isEqualTo: toCity);
      }
      final snapshot = await query.get();
      return snapshot.docs
          .map((d) => {'id': d.id, ...d.data() as Map<String, dynamic>})
          .toList();
    } catch (_) {
      return [];
    }
  }

  // ── Get parcels ───────────────────────────────────────────────────
  Future<List<Map<String, dynamic>>> getParcels({String? destination}) async {
    try {
      Query query = _firestore.collection('parcels');
      if (destination != null && destination.isNotEmpty) {
        query = query.where('destination', isEqualTo: destination);
      }
      final snapshot = await query.get();
      return snapshot.docs
          .map((d) => {'id': d.id, ...d.data() as Map<String, dynamic>})
          .toList();
    } catch (_) {
      return [];
    }
  }

  // ── Get my parcels ────────────────────────────────────────────────
  Future<List<Map<String, dynamic>>> getMyParcels() async {
    try {
      final uid = currentUid;
      if (uid == null) return [];
      final snapshot = await _firestore
          .collection('parcels')
          .where('uid', isEqualTo: uid)
          .get();
      return snapshot.docs
          .map((d) => {'id': d.id, ...d.data()})
          .toList();
    } catch (_) {
      return [];
    }
  }

  // ── Get my trips ──────────────────────────────────────────────────
  Future<List<Map<String, dynamic>>> getMyTrips() async {
    try {
      final uid = currentUid;
      if (uid == null) return [];
      final snapshot = await _firestore
          .collection('trips')
          .where('uid', isEqualTo: uid)
          .get();
      return snapshot.docs
          .map((d) => {'id': d.id, ...d.data()})
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<Object?> isChatUnlocked(String s) async {
    return null;
  }

  Future<Object?> checkRequestStatus({required String toUid, required String tripId}) async {
    return null;
  }

  Future<Object?> sendDeliveryRequest({required String toUid, required String toName, required String tripId, required String packageNote, required String packageType, required String weight, required String destination, required String proposedPayment}) async {
    return null;
  }

  Future<void> respondToRequest({required String requestId, required String response}) async {}
}


Future<void> saveTrip(TripModel trip) async {
  Object? currentUid;
  final uid = currentUid;

  if (uid == null) return;

  await FirebaseFirestore.instance.collection('trips').add({
    'uid': uid,
    'fromCode': trip.fromCode,
    'fromCity': trip.fromCity,
    'toCode': trip.toCode,
    'toCity': trip.toCity,
    'departureDate': trip.departureDate,
    'flightNumber': trip.flightNumber,
    'luggageSpace': trip.luggageSpace,
    'pricePerKg': trip.pricePerKg,
    'createdAt': FieldValue.serverTimestamp(),
  });
}