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

        char *identifier = mp3_tag3_identifier_detail(header);

        char m_body[bodySize];
        fread(m_body, bodySize, 1, file);

        totalReadCount += headerSize + bodySize;

        printf("%s", identifier);

    } while(totalReadCount < totalsize);
}

#pragma mark - Other

char *mp3_tag3_identifier_detail(MP3TAG2FrameHeader header)
{
    char *identifier = mp3_uintsToChars(header.identifier, 4);
    if (strcmp(identifier, "Iden") == 0) {
        return "Description";
    } else if (strcmp(identifier, "TRCK") == 0) {
        return "Track number";
    } else if (strcmp(identifier, "TENC") == 0) {
        return "Encoded By";
    } else if (strcmp(identifier, "WXXX") == 0) {
        return "URL";
    } else if (strcmp(identifier, "TCOP") == 0) {
        return "Frame identifier";
    } else if (strcmp(identifier, "TOPE") == 0) {
        return "Original Artist";
    } else if (strcmp(identifier, "TCOM") == 0) {
        return "Composer";
    } else if (strcmp(identifier, "TCON") == 0) {
        return "Genre";
    } else if (strcmp(identifier, "COMM") == 0) {
        return "Comments";
    } else if (strcmp(identifier, "TYER") == 0) {
        return "Year";
    } else if (strcmp(identifier, "TALB") == 0) {
        return "Album";
    } else if (strcmp(identifier, "TPE1") == 0) {
        return "Artist";
    } else if (strcmp(identifier, "TIT2") == 0) {
        return "Song name";
    }

    return identifier;
}

