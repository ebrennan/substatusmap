import pandas as pd
import ceODBC

SERVER = 'reportingdb'
DATABASE = 'Analysis'

EXCEL_FILE = 'substatus_mapping.xls'


def write_table(frame, conn, table):
    cursor = conn.cursor()

    try:
        cursor.execute('TRUNCATE TABLE[{}]'.format(table))

        cols = ','.join(frame.columns)
        wildcards = ','.join(['?'] * len(frame.columns))

        insert_query = "insert into {} ({}) values ({})".format(table, cols, wildcards)

        data = [tuple(x) for x in frame.values]

        cursor.executemany(insert_query, data)
    except:
        raise
    else:
        cursor.close()
        conn.commit()


if __name__ == '__main__':
    try:
        conn = ceODBC.connect('driver={{sql server}};server={};database={}'.format(SERVER,DATABASE))

        # parse spreadsheet
        spreadsheet = pd.ExcelFile(EXCEL_FILE)
        df = spreadsheet.parse(spreadsheet.sheet_names[0])

        # create mapping tables
        stage_substage_map = df[['StageID', 'SubStageID']].drop_duplicates()
        write_table(stage_substage_map, conn, 'StageSubStageMap')

        substage_substatus_map = df[['SubStageID','SubStatusID']].drop_duplicates()
        write_table(substage_substatus_map, conn, 'SubStageSubStatusMap')

        substatusowner_substatus_map = df[['SubStatusOwnerID','SubStatusID']].drop_duplicates()
        write_table(substatusowner_substatus_map, conn, 'SubStatusOwnerSubStatusMap')

    finally:
        conn.close()



