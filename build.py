import argparse
import os
import shelve
from itertools import islice
import numpy as np
import gzip

import nmslib


def iter_embeddings(path, limit):
    if path.endswith('.gz'):
        f = gzip.open(path)
    else:
        f = open(path, 'rb')
    for line in islice(f, limit):
        line = line.decode('utf-8')
        word, *vec = line.split()
        if len(vec) < 8:  # skip probably header lines
            continue
        yield word, np.array(vec, dtype=np.float64)
    f.close()


def build_index(vecs_path, db_path, index_path):
    index = nmslib.init()
    limit = None
    with shelve.open(db_path) as db:
        for i, (word, vec) in enumerate(iter_embeddings(vecs_path, limit)):
            index.addDataPoint(i, vec)
            db[word] = vec  # lookup word to fashion query vector
            db[str(i)] = word  # lookup words from knn index response
    index.createIndex({"post": 2}, print_progress=True)
    print()  # createIndex print progress doesn't end in new line :(
    index.saveIndex(index_path)


def main():
    build_index(os.getenv("VECS_PATH"), os.getenv("DB_PATH"), os.getenv("INDEX_PATH"))


if __name__ == "__main__":
    main()
