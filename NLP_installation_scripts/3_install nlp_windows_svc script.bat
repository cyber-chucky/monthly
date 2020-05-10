rem remove old windows service and create and start new one
.venv\Scripts\python nlp_windows_svc.py stop
.venv\Scripts\python nlp_windows_svc.py remove
copy .venv\Lib\site-packages\pywin32_system32\pywintypes36.dll .venv\Lib\site-packages\win32\ /Y
.venv\Scripts\python nlp_windows_svc.py --username ac\rap_batch --password 12dgPF1Q# --startup auto install
.venv\Scripts\python nlp_windows_svc.py start