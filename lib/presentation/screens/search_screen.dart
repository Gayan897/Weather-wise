// lib/presentation/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/weather_providers.dart';


class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _recentSearches = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      ref.read(citySearchProvider.notifier).searchCities(query);
    }
  }

  void _addToRecentSearches(String cityName) {
    setState(() {
      _recentSearches.remove(cityName);
      _recentSearches.insert(0, cityName);
      if (_recentSearches.length > 10) {
        _recentSearches = _recentSearches.sublist(0, 10);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(citySearchProvider);
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Cities'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a city...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(citySearchProvider.notifier).clear();
                          setState(() {});
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              onChanged: (value) {
                setState(() {});
                if (value.length >= 2) {
                  _performSearch(value);
                } else {
                  ref.read(citySearchProvider.notifier).clear();
                }
              },
              onSubmitted: _performSearch,
            ),
          ),

          // Search Results
          Expanded(
            child: searchResults.when(
              data: (results) {
                if (_searchController.text.isEmpty) {
                  // Show recent searches and favorites
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_recentSearches.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Recent Searches',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _recentSearches.clear();
                                    });
                                  },
                                  child: const Text('Clear'),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _recentSearches.length,
                            itemBuilder: (context, index) {
                              final cityName = _recentSearches[index];
                              return ListTile(
                                leading: const Icon(Icons.history),
                                title: Text(cityName),
                                onTap: () {
                                  Navigator.pop(context, cityName);
                                },
                                trailing: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      _recentSearches.removeAt(index);
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                        favoritesAsync.when(
                          data: (favorites) {
                            if (favorites.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Favorite Cities',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: favorites.length,
                                  itemBuilder: (context, index) {
                                    final location = favorites[index];
                                    return ListTile(
                                      leading: const Icon(Icons.favorite, color: Colors.red),
                                      title: Text(location.name),
                                      subtitle: Text('${location.country}'),
                                      onTap: () {
                                        _addToRecentSearches(location.name);
                                        Navigator.pop(context, location.name);
                                      },
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                          loading: () => const SizedBox.shrink(),
                          error: (_, __) => const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  );
                }

                if (results.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No cities found',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try a different search term',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final location = results[index];
                    return FutureBuilder<bool>(
                      future: ref
                          .read(favoritesRepositoryProvider)
                          .isFavorite(location),
                      builder: (context, snapshot) {
                        final isFavorite = snapshot.data ?? false;
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              location.country,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          title: Text(location.name),
                          subtitle: Text(
                            location.state != null
                                ? '${location.state}, ${location.country}'
                                : location.country,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : null,
                            ),
                            onPressed: () async {
                              if (isFavorite) {
                                await ref
                                    .read(favoritesProvider.notifier)
                                    .removeFavorite(location);
                              } else {
                                await ref
                                    .read(favoritesProvider.notifier)
                                    .addFavorite(location);
                              }
                              setState(() {});
                            },
                          ),
                          onTap: () {
                            _addToRecentSearches(location.name);
                            Navigator.pop(context, location.name);
                          },
                        );
                      },
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: ${error.toString()}'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}