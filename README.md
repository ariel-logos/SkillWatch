# SkillWatch

## What is it?
Skillwatch is an add-on for FFXI's third-party loader and hook Ashita (https://www.ashitaxi.com/).
Very simply, the purpose of this add-on is to have a clearer way to indentify the moment when enemy mobs "ready" a skill.
This could be useful in a variety of situations, for example, when people are playing with relevant ping issues or the time window to react to such event is in general too short.

## What is not?
This add-on is <b>NOT</b> a bot. It simply provides enhanced feedback on enemy mobs readying their skills with the same timing the typical "X readies Y." message would appear in the chat box.

## How does it work?
In short, it's a combination of parsing the chat box looking for a message, matching it with Entity informations provided by Ashita hook and drawing some visual feedback overlay.


<video width=200; src="https://private-user-images.githubusercontent.com/78350872/292670239-81efeb44-ed4e-4e01-b039-368add970f7a.mp4?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDM0MjEwNzMsIm5iZiI6MTcwMzQyMDc3MywicGF0aCI6Ii83ODM1MDg3Mi8yOTI2NzAyMzktODFlZmViNDQtZWQ0ZS00ZTAxLWIwMzktMzY4YWRkOTcwZjdhLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMjQlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjI0VDEyMjYxM1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTRkYTY5MjFhNWU0MmIyYjE5Y2E0ZTY2NTc5N2ZjN2EzMjRhOWM1MjYzZDdlMzUyNjhjM2Y5NWM2Mzg2NTU1YWMmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.pm5IatZcQSk2kdn8x0fmRDQp2WAkgnIxYwki24JUOeA" data-canonical-src="https://private-user-images.githubusercontent.com/78350872/292670239-81efeb44-ed4e-4e01-b039-368add970f7a.mp4?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDM0MjEwNzMsIm5iZiI6MTcwMzQyMDc3MywicGF0aCI6Ii83ODM1MDg3Mi8yOTI2NzAyMzktODFlZmViNDQtZWQ0ZS00ZTAxLWIwMzktMzY4YWRkOTcwZjdhLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMjQlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjI0VDEyMjYxM1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTRkYTY5MjFhNWU0MmIyYjE5Y2E0ZTY2NTc5N2ZjN2EzMjRhOWM1MjYzZDdlMzUyNjhjM2Y5NWM2Mzg2NTU1YWMmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.pm5IatZcQSk2kdn8x0fmRDQp2WAkgnIxYwki24JUOeA" controls="controls" muted="muted" class="d-block rounded-bottom-2 border-top width-fit" style="max-height:640px; min-height: 200px">

  </video>
