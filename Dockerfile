FROM golang:1.19.1-buster as go-target
RUN apt-get update && apt-get install -y wget
ADD . /wav
WORKDIR /wav
RUN wget https://www2.cs.uic.edu/~i101/SoundFiles/Fanfare60.wav
RUN wget https://www2.cs.uic.edu/~i101/SoundFiles/BabyElephantWalk60.wav
RUN wget https://www2.cs.uic.edu/~i101/SoundFiles/preamble.wav
RUN wget https://www2.cs.uic.edu/~i101/SoundFiles/StarWars3.wav
RUN wget https://www2.cs.uic.edu/~i101/SoundFiles/preamble10.wav
RUN wget https://www2.cs.uic.edu/~i101/SoundFiles/taunt.wav
RUN wget https://www2.cs.uic.edu/~i101/SoundFiles/StarWars3.wav
RUN mkdir ./testdata/
RUN mv *.wav ./testdata/
WORKDIR /wav/cmd/metadata
RUN go build

FROM golang:1.19.1-buster
COPY --from=go-target /wav/cmd/metadata/metadata /
COPY --from=go-target /wav/testdata/*.wav /testsuite/

ENTRYPOINT []
CMD ["/metadata", "@@"]
