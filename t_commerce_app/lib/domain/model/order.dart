import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

enum Status { created, confirm, transported, completed, canceled }

extension StatusExtension on Status {
  int get id {
    switch (this) {
      case Status.created:
        return 1;
      case Status.confirm:
        return 2;
      case Status.transported:
        return 3;
      case Status.completed:
        return 4;
      case Status.canceled:
        return 5;
    }
  }

  static Status getStatus({required int id}) {
    switch (id) {
      case 1:
        return Status.created;
      case 2:
        return Status.confirm;
      case 3:
        return Status.transported;
      case 4:
        return Status.completed;
      case 5:
        return Status.canceled;
      default:
        return Status.created;
    }
  }
}

class Order implements ModelType {
  final String id = Uuid().v4();
  final String phone;
  final String customerName;
  final String address;
  final Status status;
  final int createDate;
  final int updatedDate;
  final String note;

  Order(this.phone, this.customerName, this.address, this.status,
      this.createDate, this.updatedDate, this.note);

  Order.create(this.phone, this.customerName, this.address, this.status,
      this.createDate, this.updatedDate, this.note);

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
