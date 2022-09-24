import os

# 合并文件内容到一个新的文件
def concatStr(filePath,rootDir):
    #读取文件内容
    file1=open(filePath,'r',encoding='utf-8-sig')
    # 新文件
    file2 = open(rootDir+'\\result.txt', 'a+', encoding='utf-8')
    types = filePath.split('\\')
    type = types[len(types)-2]
    # 尝试写入内容到新文件
    try:
        # 写入平台名称（父级文件夹名称）
        file2.write(type+' | '+type+' | '+type+' | '+type+' | '+type+' | '+type)
        file2.write('\n')
        file2.write('-----------------------------------------------------------------')
        file2.write('\n')
        for line in file1:
            # 写入文件
            file2.write(line)
        # 补充换行
        file2.write('\n')
    finally:
        file1.close()
        file2.close()

def openDir(filePath,rootDir):#递归文件夹
    pathDir=os.listdir(filePath)#返回包含的文件或文件夹的名字的列表
    for filename in pathDir:#遍历列表
        childPath=os.path.join(filePath,filename)

        a = os.path.isfile(childPath)

        #判断是否为文件夹
        if os.path.isfile(childPath):
            concatStr(childPath,rootDir)
        else:
            openDir(childPath,rootDir)





if __name__ == '__main__':
    rootDir=r'C:\\Users\\xxxxx\\Documents\\街机\\xxxxx\\xxxxxx\\xxxx\\xxxxx\\xxxxx'
    # rootDir=r'C:\\Users\\xxxxx\\Desktop\\test'

    pathDir =  os.listdir(rootDir)#列出根目录下所有内容

    for allDir in pathDir:#遍历列表
        if allDir == 'result.txt':
            continue
        filepath=os.path.join(rootDir,allDir)#文件路径合成
        aa = os.path.isfile(filepath)
        #判断是否为文件夹
        if os.path.isfile(filepath):
            concatStr(filepath,rootDir)
        else:
            openDir(filepath,rootDir)