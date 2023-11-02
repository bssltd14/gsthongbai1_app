
import 'package:equatable/equatable.dart';

abstract class PawnItemEvent extends Equatable {
  const PawnItemEvent();

  @override
  List<Object> get props => [];
}

class FetchPawnItem extends PawnItemEvent {
  String searchPawnId;
  String searchBranchName;

  FetchPawnItem(this.searchPawnId,this.searchBranchName);
  @override
  String toString()=> "FetchPawnItem searchPawnId:${searchPawnId} searchBranchName:${searchBranchName}";
}

