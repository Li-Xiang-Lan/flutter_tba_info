class ReferrerObserver{
  const ReferrerObserver({
    this.onSuccess,
    this.onError
  });

  final void Function(Map map)? onSuccess;
  final void Function()? onError;
}