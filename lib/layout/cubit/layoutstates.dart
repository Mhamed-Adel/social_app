abstract class LayoutStates{}
class LayoutGetUserInitialState extends LayoutStates{}
class LayoutGetUserLoadingState extends LayoutStates{}
class LayoutGetUserSuccessState extends LayoutStates{}
class LayoutGetUserErrorState extends LayoutStates{
  final String error;

  LayoutGetUserErrorState(this.error);
}