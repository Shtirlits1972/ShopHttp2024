class RequestContainer {
  String message = '';
  int status = 0;

  RequestContainer(this.message, this.status);

  RequestContainer.empty() {
    this.message = '';
    this.status = 0;
  }

  @override
  String toString() {
    return 'message = $message, status = $status';
  }
}
