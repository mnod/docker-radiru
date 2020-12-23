# summay

## build

    docker build -t rec_radio .

## run

    docker run --rm -v /media/recorder:/media/recorder rec_radio <station> <minute> [comment]

station: NHKR1 | NHKR2 | NHK-FM
You can ommit [comment].
The file name will be YYYYMMDD_<station>[_<comment>].m4a
