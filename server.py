import nmslib
import shelve
import os
import bottle


db = shelve.open(os.getenv('DB_PATH', 'r'))
index = nmslib.init()
index.loadIndex(os.getenv('INDEX_PATH'))

@bottle.route('/query/word')
def query():
    return 'hello!'

