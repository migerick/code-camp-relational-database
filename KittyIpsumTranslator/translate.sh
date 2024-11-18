#!/bin/bash

cat $1

cat $1 | sed 's/catnip/dogchow/'

cat $1 | sed 's/catnip/dogchow/; s/cat/dog/'

cat $1 | sed 's/catnip/dogchow/; s/cat/dog/; s/meow/woof/'

cat $1 | sed 's/catnip/dogchow/g; s/cat/dog/g; s/meow/woof/g'

cat $1 | sed -E 's/catnip/dogchow/g; s/cat/dog/g; s/meow|meowzer/woof/g'
