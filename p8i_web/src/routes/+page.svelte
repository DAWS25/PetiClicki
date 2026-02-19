<script lang="ts">
  import { onMount } from 'svelte';
  import L from 'leaflet';
  import 'leaflet/dist/leaflet.css';

  let mapEl: HTMLDivElement;

  onMount(() => {
    // Initialize map using the installed Leaflet package
    // Center on Barceloneta, Barcelona moved another ~500m north
    const map = L.map(mapEl, { fullscreenControl: true }).setView([41.378025, 2.1900], 18);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    // Place 3 random cat emoji markers near the center
    const center = map.getCenter();
    function randomOffset() {
      // about +-0.003 degrees ~ a few hundred meters
      return (Math.random() - 0.5) * 0.006;
    }

    for (let i = 0; i < 3; i++) {
      const lat = center.lat + randomOffset();
      const lng = center.lng + randomOffset();
      const catIcon = L.divIcon({
        className: 'cat-marker',
        html: '🐱',
        iconSize: [64, 64]
      });
      L.marker([lat, lng], { icon: catIcon }).addTo(map).bindPopup('Random cat');
    }
  });
</script>

<svelte:head>
  <meta name="viewport" content="width=device-width,initial-scale=1" />
</svelte:head>

<div bind:this={mapEl} class="map" />

<div class="overlay" role="banner">
  <img src="/images/logo.png" alt="PetiClicki logo" class="logo" />
</div>

<style>
  :global(html,body,#svelte) { height:100%; margin:0 }
  .map { position:fixed; inset:0; width:100%; height:100%; }
  .overlay {
    position:fixed; bottom:1rem; left:1rem; display:flex; align-items:center; gap:0.5rem;
    background:rgba(255,255,255,0.9); padding:0.25rem 0.5rem; border-radius:12px; box-shadow:0 6px 18px rgba(2,6,23,0.12);
  }
  .overlay .logo { height:96px; width:auto; display:block }
  .cat-marker {
    font-size:56px; line-height:56px; display:flex; align-items:center; justify-content:center;
    width:72px; height:72px; border-radius:50%; background:rgba(255,255,255,0.95);
    border:2px solid rgba(12,18,32,0.12); box-shadow:0 6px 18px rgba(2,6,23,0.18); cursor:pointer;
    transition:transform 120ms ease, box-shadow 120ms ease;
  }
  .cat-marker:hover { transform:scale(1.12); box-shadow:0 10px 26px rgba(2,6,23,0.24) }
</style>
