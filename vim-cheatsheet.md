# Vim Cheat Sheet

## Basic File/Dir work
```
:cd ${/some/dir}            # Change to some dir
:pwd                        # List current Directory
:e ${/some/file}            # Edit some file
```

## Buffer Management
### Buffer Deletion
```
:bd                         # deletes the current buffer, error if there are unwritten changes
:bd!                        # deletes the current buffer, no error if unwritten changes
:bufdo bd                   # deletes all buffers, stops at first error (unwritten changes)
:bufdo! bd                  # deletes all buffers except those with unwritten changes
:bufdo! bd!                 # deletes all buffers, no error on any unwritten changes
    ```
### Less Safe Buffer Deletion
    ```
:bw                         # completely deletes the current buffer, error if there are unwritten changes
:bw!                        # completely deletes the current buffer, no error if unwritten changes
:bufdo bw                   # completely deletes all buffers, stops at first error (unwritten changes)
:bufdo! bw                  # completely deletes all buffers except those with unwritten changes
:bufdo! bw!                 # completely deletes all buffers, no error on any unwritten changes

:set confirm                # confirm changes (Yes, No, Cancel) instead of error
```
### Other Handy Buffer Commands
```
:b${#}                      # switch buffer to desired buffer number
:ls                         # list all buffers
:vs                         # Vertical Split: Split the buffer vertically
:vs ${/file/name}           # Vertical Split and open a file into the buffer
```


