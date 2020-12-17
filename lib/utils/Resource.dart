import 'package:daloouser/utils/Constant.dart';

class Resource<ResultType> {
  ResourceState state;
  ResultType data;
  String exception;
  double progress;

  Resource({this.state, this.data, this.exception,this.progress});

  static Resource<ResultType> loading<ResultType>(double load) {
    return Resource(state: ResourceState.LOADING,progress: load);
  }

  static Resource<ResultType> complete<ResultType>(ResultType data) {
    return Resource(state: ResourceState.COMPLETE, data: data);
  }

  static Resource<ResultType> error<ResultType>(String exception) {
    return Resource(state: ResourceState.ERROR, exception: exception);
  }
}