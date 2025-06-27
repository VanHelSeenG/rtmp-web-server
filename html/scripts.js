function startVideo() {
			document.getElementById('video_runner').remove();

			const video = document.getElementById('video');
            const streamKey = window.location
                                    .search
                                    .substring(1)
                                    .split('&')
                                    .map(x => x.split('='))
                                    .filter(x => x[0] == 'key')
                                    .map(x => x[1])[0]
        
            const streamUrl = window.location.origin + `/hls/${streamKey}.m3u8`;

			if (Hls.isSupported()) {
				const hls = new Hls();
				hls.loadSource(streamUrl);
				hls.attachMedia(video);
				hls.on(Hls.Events.MANIFEST_PARSED, () => video.play());
			} else if (video.canPlayType('application/vnd.apple.mpegurl')) {
				// Для Safari (который поддерживает HLS нативно)
				video.src = streamUrl;
				video.addEventListener('loadedmetadata', () => video.play());
			}
		}