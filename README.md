# Nasa-iOS
- Using Combine for data fetching
- The "NasaStore" handles the data fetching and stores the data. As the app grows other views may also need to use the data, hence the Store keeps the single source of data and makes it available fo any view to use.
- The NasaStore is a singleton to prevent duplicate data fetches and maintains the state of the data in one place.
- I named the store "Store" as I feel the word "ViewModel" implies that the layer that maintains the business logic is coupled to its "view". I prefer that it is seperated from the view's concerns in a logical way. The store feeds any view with sorted and presentable data.
- Furthermore, using the Observer Pattern and Pasthrough subjects to notifiy the view when the data is fetched, means that any view that subscribes to these changes will be notified. 
- The store fetches as much data as possible when it is instatiated, and this call is not bound to a particular view.
