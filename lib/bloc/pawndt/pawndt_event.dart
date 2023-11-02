
import 'package:equatable/equatable.dart';

abstract class PawnDtEvent extends Equatable {
  const PawnDtEvent();

  @override
  List<Object> get props => [];
}

class FetchPawnDt extends PawnDtEvent {
  String searchPawnId;
  String searchBranchName;

  FetchPawnDt(this.searchPawnId,this.searchBranchName);
  @override
  String toString()=> "FetchPawnDt searchPawnId:${searchPawnId} searchBranchName:${searchBranchName}";
}


