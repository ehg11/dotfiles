import os
import argparse
import PyPDF2

def mergePDFs(inputFiles, outputFile):
    merger = PyPDF2.PdfMerger()

    for filename in inputFiles:
        with open(filename, 'rb') as file:
            merger.append(file)

    with open(outputFile, 'wb') as file:
        merger.write(file)

def getChapter(filename):
    num = filename.split(' ')[1][:-1]
    return int(num)

def getLectureNum(filename):
    return int(filename[:2])

if __name__ == "__main__":
    currentDir = os.getcwd()

    parser = argparse.ArgumentParser()

    # 2 arguments: --output/-o, --input/-i
    parser.add_argument(
        '-o',
        '--output',
        type=str,
        default='merged.pdf'
    )

    parser.add_argument(
        '-i',
        '--input',
        type=str,
        nargs='+'
    )

    args = parser.parse_args()
    output: str = args.output
    pdfs = args.input

    if not output.endswith('.pdf'):
        output = output + '.pdf' 

    mergePDFs(pdfs, output)
