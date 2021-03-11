# Extended Clipboard
## How to use:
If you want to override paste in TextField:

    TextField(
      selectionControls: Platform.isAndroid
      ? null
      : ExtendedCupertinoTextSelectionControls(onPasteImage: (File image) {
      //Handle paste image
      }),
    )
Or if you want get current value from clipboard:

    final data = await ExtendedClipboard.clipboard();
    if (data != null) {
      if (data is File) {
        //Handle for image
      } else if (data is String) {
        //Handle fot text
      }
    }

