enum FoodSortRule {
  rating,
  priceLowToHigh,
  priceHighToLow,
  distanceClosestFirst,
  distanceFarthestFirst,
  recentOrdersFirst,
  recentOrdersLast
}
// Filter encompasses two types of action, sorting and selecting basing on a common characteristic. The feed must be initialised successfully to apply sorting and filtering. 
// Sorting options: price, rating (1 -5), delivery time add-up both ascending and descending. Filtering options: price-tier (<=Q1, IQR, Q3=>) discount availability, vegetarian, vegan, pescetarian, Thai, Chinese, Indian, Japanese, Vietnamese.
// Sorting and filtering are performed on Feed.