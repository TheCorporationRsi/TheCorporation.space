'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "06a3d73881fcd7cefd7dbc0859f890c0",
"assets/AssetManifest.bin.json": "52b54bfa3525ddebd61b6d4519adbc0c",
"assets/AssetManifest.json": "f790ec6f5b9eeb5441a9b3fd84f06412",
"assets/assets/icons/burn.png": "51a00d14b99445134c8a11128b008510",
"assets/assets/icons/distance.png": "ed13215b061db489e5d452f3c0a74fd4",
"assets/assets/icons/Documents.svg": "0d66436fde3818811c82319665ef91fd",
"assets/assets/icons/folder.svg": "8c11f522cd36f0cbd9c02eb2b689cbb9",
"assets/assets/icons/media.svg": "e790cb1d2138f7a9d1b404abf8346eb1",
"assets/assets/icons/sleep.png": "6196f7d5ca8c361bce775098b428c4bf",
"assets/assets/icons/steps.png": "3c0a0084eb6bf70752bae7545cc694ce",
"assets/assets/icons/unknown.svg": "2fc91e195e7a0d6279c01552403c3b89",
"assets/assets/images/avatar.png": "5aad78214cf890564ddc640ba02c561f",
"assets/assets/images/department_mixed.png": "ac7c1e5ea3410d01536bbae4fe75e53a",
"assets/assets/images/evil_corps.png": "e15388ccdf835d461e22904000673c2b",
"assets/assets/images/login_background.jpg": "cbe6aedea2fb5b6583aa314d6bf8200e",
"assets/assets/images/pers_stats.png": "67b514c7cea0165617fdb55212bf2948",
"assets/assets/images/side_menu.png": "22e28ad082a682733e273ca6dbca337e",
"assets/assets/images/structure_section.png": "aa54b1e29e47b002ae1c7302cecbb4c1",
"assets/assets/images/transfer_section.png": "b2d6cf054c6e3194be6b2607d5a73ae9",
"assets/assets/images/weights_section.png": "374327224d294a26f2a9bc52266999b3",
"assets/assets/logo/corp_banner.png": "9a00047d32d052f0a2f4d42f83808ce7",
"assets/assets/logo/corp_logo.png": "21d4f27cfc419d2500f6e6ca4df16753",
"assets/assets/logo/department.svg": "c3f5c7fd3d35ef9fe624093000cceee4",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "2f01099cc779bcea301790291f748470",
"assets/NOTICES": "6ad894bcc9bf7a02c19b8acf5d1acbd3",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"corplogo.ico": "5af9c311dbd3d0f5146ec9121aad5e62",
"corplogo.png": "871a4d5cfe4b8333874b122212bbdef1",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "6575541d90d2ce3970f01565e87f3f48",
"icons/Icon-192.png": "bdd017ae44bd12020c13aa916781ba8c",
"icons/Icon-512.png": "d5af04f1dee0b00f45703737f9c6bb1d",
"icons/Icon-maskable-192.png": "bdd017ae44bd12020c13aa916781ba8c",
"icons/Icon-maskable-512.png": "d5af04f1dee0b00f45703737f9c6bb1d",
"index.html": "e6bad49bc47561db28c811ad50d56cf6",
"/": "e6bad49bc47561db28c811ad50d56cf6",
"main.dart.js": "1b4d5dde269e887996ec3955f29b802b",
"manifest.json": "164c7c76db7c1482773b4ef719d99fe1",
"version.json": "d491dca405bf7fe559194bd348106196"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
