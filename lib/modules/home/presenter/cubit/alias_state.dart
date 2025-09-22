import 'package:equatable/equatable.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';

abstract class AliasState extends Equatable {}

class AliasInitial extends AliasState {
  @override
  List<Object?> get props => [];
}

class AliasLoading extends AliasState {
  @override
  List<Object?> get props => [];
}

class AliasesLoaded extends AliasState {
  final List<AliasModel> aliases;

  AliasesLoaded(this.aliases);

  @override
  List<Object?> get props => [aliases];
}

class AliasError extends AliasState {
  final String message;

  AliasError(this.message);

  @override
  List<Object?> get props => [message];
}
