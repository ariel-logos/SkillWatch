# SkillWatch

## What is it?
Skillwatch is an add-on for FFXI's third-party loader and hook Ashita (https://www.ashitaxi.com/).
Very simply, the purpose of this add-on is to have a clearer way to indentify the moment when enemy mobs "ready" a skill.
This could be useful in a variety of situations, for example, when people are playing with relevant ping issues or the time window to react to such event is in general too short.

## What is not?
This add-on is <b>NOT</b> a bot. It simply provides enhanced feedback on enemy mobs readying their skills with the same timing the typical "X readies Y." message would appear in the chat box.

## How does it work?
In short, it's a combination of parsing the chat box looking for a message, matching it with Entity informations provided by Ashita hook and drawing some visual feedback overlay.

<video src="https://private-user-images.githubusercontent.com/78350872/292667738-4dd8e67a-a4f3-4b2f-8a03-db14c797d021.mp4?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDM0MTczMTksIm5iZiI6MTcwMzQxNzAxOSwicGF0aCI6Ii83ODM1MDg3Mi8yOTI2Njc3MzgtNGRkOGU2N2EtYTRmMy00YjJmLThhMDMtZGIxNGM3OTdkMDIxLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMjQlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjI0VDExMjMzOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTY3NzJlZGJmNzAzOWE1MmRjNjExNjBlYzllYTI5Zjc3M2U1NWI2MTQyY2VlZGFiY2ZlM2JjNzI4Nzk5MWEwMjEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.n6VbhQ0OuM2YLdknCtR0YtUZhoZ8jPDkk8wBgx73_44" data-canonical-src="https://private-user-images.githubusercontent.com/78350872/292667738-4dd8e67a-a4f3-4b2f-8a03-db14c797d021.mp4?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDM0MTczMTksIm5iZiI6MTcwMzQxNzAxOSwicGF0aCI6Ii83ODM1MDg3Mi8yOTI2Njc3MzgtNGRkOGU2N2EtYTRmMy00YjJmLThhMDMtZGIxNGM3OTdkMDIxLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMjQlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjI0VDExMjMzOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTY3NzJlZGJmNzAzOWE1MmRjNjExNjBlYzllYTI5Zjc3M2U1NWI2MTQyY2VlZGFiY2ZlM2JjNzI4Nzk5MWEwMjEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.n6VbhQ0OuM2YLdknCtR0YtUZhoZ8jPDkk8wBgx73_44" controls="controls" muted="muted" class="d-block rounded-bottom-2 border-top width-fit" style="max-height:100px; min-height: 50px">
</video>
