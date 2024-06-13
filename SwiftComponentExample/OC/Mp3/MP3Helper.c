//
//  MP3Helper.c
//  OC
//
//  Created by Jingfu Li on 2024/6/13.
//

#include "MP3Helper.h"
#include "MP3Util.h"
#include <string.h>
#include <math.h>

void mp3_test(FILE *file)
{
    fseek(file, 0, SEEK_SET);

    char data[100000];
    fread(data, sizeof(data), 1, file);

    printf("%s", data);
}

#pragma mark -

int mp3_get_tag2(FILE *file, MP3TAG2 *tag)
{
    fseek(file, 0, SEEK_SET);
    size_t size = sizeof(tag);
    return fread(tag, sizeof(size), 1, file) == size;
}

size_t mp3_get_tag2_size(MP3TAG2 tag)
{
    return mp3_powCharsToIngetal(tag.size, 4, pow(2, 7));
}

size_t mp3_get_tag2_header_size(MP3TAG2 tag)
{
    size_t size = mp3_get_tag2_size(tag);
    return size > 0 ? size + 10 : 0;
}

void mp3_tag2_dump(FILE *file, MP3TAG2 tag)
{
    mp3_test(file);

    size_t totalsize = mp3_get_tag2_size(tag);
    size_t totalReadCount = 0;

    fseek(file, 10, SEEK_SET);

    do {
        MP3TAG2FrameHeader header;
        size_t headerSize = sizeof(header);
        fread(&header, headerSize, 1, file);

        size_t bodySize = mp3_convertCharsToIngetal(header.size, 4, 0b1111111);

        char identifier[100];
        mp3_tag3_identifier_detail(header, identifier);

        mp3_print(header.identifier);
        printf("\n");

        char m_body[bodySize];
        fread(m_body, bodySize, 1, file);

        totalReadCount += headerSize + bodySize;

    } while(totalReadCount < totalsize);
}

#pragma mark - Other

void mp3_tag3_identifier_detail(MP3TAG2FrameHeader header, char *identifier)
{
    mp3_uintsToChars(header.identifier, identifier);
    if (strcmp(identifier, "Iden") == 0) {
        identifier = "Description";
    } else if (strcmp(identifier, "TRCK") == 0) {
        identifier = "Track number";
    } else if (strcmp(identifier, "TENC") == 0) {
        identifier = "Encoded By";
    } else if (strcmp(identifier, "WXXX") == 0) {
        identifier = "URL";
    } else if (strcmp(identifier, "TCOP") == 0) {
        identifier = "Frame identifier";
    } else if (strcmp(identifier, "TOPE") == 0) {
        identifier = "Original Artist";
    } else if (strcmp(identifier, "TCOM") == 0) {
        identifier = "Composer";
    } else if (strcmp(identifier, "TCON") == 0) {
        identifier = "Genre";
    } else if (strcmp(identifier, "COMM") == 0) {
        identifier = "Comments";
    } else if (strcmp(identifier, "TYER") == 0) {
        identifier = "Year";
    } else if (strcmp(identifier, "TALB") == 0) {
        identifier = "Album";
    } else if (strcmp(identifier, "TPE1") == 0) {
        identifier = "Artist";
    } else if (strcmp(identifier, "TIT2") == 0) {
        identifier = "Song name";
    }
}

