//
//  MP3Helper.c
//  OC
//
//  Created by Jingfu Li on 2024/6/13.
//

#include "MP3Helper.h"
#include "MP3Util.h"
#include <string.h>

void mp3_test(FILE *file)
{
    fseek(file, 0, SEEK_SET);

    char data[100];
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
    char *size = tag.size;
    return size[3] & 0x0111 + 
        size[2] & 0x0111 * 16 +
        size[1] & 0x0111 * (16 ^ 2) +
        size[0] & 0x0111 * (16 ^ 3);
}

size_t mp3_get_tag2_header_size(MP3TAG2 tag)
{
    size_t size = mp3_get_tag2_size(tag);
    return size > 0 ? size + 10 : 0;
}

void mp3_tag2_dump(FILE *file, MP3TAG2 tag)
{
    mp3_test(file);

    size_t size = mp3_get_tag2_size(tag);
    size_t readCount = 0;

    fseek(file, 10, SEEK_SET);

    do {
        MP3TAG2FrameHeader header;
        size_t headerSize = sizeof(header);
        readCount += fread(&header, headerSize, 1, file) * headerSize;

        size_t size = mp3_convertCharArrayToIngetal(header.size, 4, 0x1111);
        readCount += size;

        char *identifier = mp3_tag3_identifier_detail(header);
        char description[size - 1];

        // header 后面 1 byte == 00
        fseek(file, 10 + readCount + 1, SEEK_SET);

        char m_description[size - 1];
        fread(m_description, size - 1, 1, file);

        int i;

    } while(readCount < size);
}

#pragma mark - Other

char *mp3_tag3_identifier_detail(MP3TAG2FrameHeader header)
{
    char *identifier = header.identifier;
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

