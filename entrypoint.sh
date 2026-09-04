#!/bin/bash

# تنظیم پورت پنل روی 2053
/app/x-ui setting -port 2053

# تزریق لینک کانال تلگرام به قالب‌ها و بخش ساب‌لینک
python3 -c '
import os

telegram_btn = """
<a href="https://t.me/+F84b6ebZYdw0ZmZk" target="_blank" style="position: fixed; bottom: 20px; right: 20px; background: linear-gradient(135deg, #0088cc, #005580); color: white; padding: 10px 18px; border-radius: 30px; z-index: 9999; box-shadow: 0 4px 15px rgba(0,0,0,0.4); text-decoration: none; font-family: sans-serif; font-size: 14px; font-weight: bold; border: 1px solid rgba(255,255,255,0.2);">📢 کانال تلگرام ما</a>
"""

for root, dirs, files in os.walk("/app/web"):
    for file in files:
        if file.endswith(".html"):
            path = os.path.join(root, file)
            try:
                with open(path, "r", encoding="utf-8", errors="ignore") as f:
                    content = f.read()
                if "</body>" in content and "t.me" not in content:
                    content = content.replace("</body>", telegram_btn + "</body>")
                    with open(path, "w", encoding="utf-8") as f:
                        f.write(content)
            except Exception as e:
                print(f"Error: {e}")
'

# اجرای نهایی پنل سنایی
exec /app/x-ui
