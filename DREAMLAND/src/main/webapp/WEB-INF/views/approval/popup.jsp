 <%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>  
      <!DOCTYPE html>
        <html lang="ko">
        <head>
            <meta charset="UTF-8">
            <title>반려 사유</title>
        </head>
        <body>
            <form id="popupForm">
                <label for="rejectedReason">반려 사유:</label>
                <input type="text" id="rejectedReason" name="rejectedReason" required>
                <button type="submit">확인</button>
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