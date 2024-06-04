      <!DOCTYPE html>
        <html lang="ko">
        <head>
            <meta charset="UTF-8">
            <title>Popup Form</title>
        </head>
        <body>
            <form id="popupForm">
                <label for="rejectedReason">Enter some text:</label>
                <input type="text" id="rejectedReason" name="rejectedReason" required>
                <button type="submit">Submit</button>
            </form>
            <script>
                document.getElementById('popupForm').addEventListener('submit', function(event) {
                    event.preventDefault();
                    const inputText = document.getElementById('rejectedReason').value;
                    window.opener.handlePopupFormSubmission(inputText);
                    window.close();
                });
            </script>
        </body>
        </html>