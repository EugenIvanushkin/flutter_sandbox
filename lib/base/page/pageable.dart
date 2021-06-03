abstract class Pageable<T> {
  final int pageSize;
  final double loadThreshold;
  int lastLoadedPage;
  List<T> items = [];
  int totalCount = 0;
  bool isLoading = false;

  bool get hasMore => items.length < totalCount;
  bool get canLoad => !isLoading && (lastLoadedPage == null || hasMore);
  int get nextPage => (lastLoadedPage ?? 0) + 1;

  Pageable({this.pageSize = 30, this.loadThreshold = 10});

  bool needLoadMore(int index) {
    if (!canLoad) return false;
    return index > items.length - loadThreshold;
  }

  void pageLoaded(List<T> items, int total) {
    this.items.addAll(items);
    this.totalCount = total;
    lastLoadedPage = nextPage;
  }

  void resetPage() {
    items.clear();
    totalCount = 0;
    lastLoadedPage = null;
  }
}