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
:bw                         # completely deletes the current buffer,
                            error if there are unwritten changes
:bw!                        # completely deletes the current buffer, 
                            no error if unwritten changes
:bufdo bw                   # completely deletes all buffers, 
                            stops at first error (unwritten changes)
:bufdo! bw                  # completely deletes all buffers 
                            except those with unwritten changes
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

### Handy Tab Commands

```
:tabnew                     # open a new tab
:tabnew ${/file/name}       # open a file to a new tab
$ vim -p file1 file2 file3  # start vim with listed files in tabs
:tabf ${/file/name}         # search for a file thats open in a tab
:tabn                       # switch to next tab
:tabp                       # switch to previous tab
gt                          # in normal mode switch tab
:tabdo                      # run a command in all open tabs
                            ex: :tabdo %s/foo/bar/g
                            does a search and replace on every open tab
```

### Working with lines

```
:retab                      # replace existing tabs with your set tabs ex: tabs for spaces
yy                          # copy/yank line
dd                          # cut line
                            # Both yy and dd can be prefaced with a number to
                            get and exact abount of lines
p                           # paste what you cut/yank/copies
:noh                        # unhighlight all of the text you highlighted in
                            your search
```

