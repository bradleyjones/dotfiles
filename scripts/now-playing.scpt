on run
  set info to ""
  tell application "System Events"
    set runCount to count (every process whose name is "iTunes")
  end tell
  if runCount > 0 then
    tell application "iTunes"
      if player state is playing then
        set _artist to artist of current track
        set _title to name of current track
        set _album to album of current track
        set _currentpos to player position
        set _duration to duration of current track
        set info to _title & " - " & _artist as string
      end if
    end tell
  end if
  tell application "System Events"
    set runCount to count (every process whose name is "Spotify")
  end tell
  if runCount > 0 then
    tell application "Spotify"
      if player state is playing then
        set _artist to artist of current track
        set _title to name of current track
        set _album to album of current track
        set _currentpos to player position
        set _duration to duration of current track
        set info to _title & " - " & _artist as string
      end if
    end tell
  end if
  set levelofdetail to 20
  set playbackpos to round (levelofdetail * _currentpos / _duration)
  set playback to "{"
  repeat playbackpos times
    set playback to playback & "-"
  end repeat
  repeat levelofdetail - playbackpos times
    set playback to playback & " "
  end repeat
  set playback to playback & "} "
  return playback & info
end run

