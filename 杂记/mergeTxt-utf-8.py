import os

def isFile(filePath,f):#批量读取文件
    filename=filePath.split('\\')[-1]#拆分文件路径获得文件名
    # 打印文件名
    print("修改前文件名:"+filename)
    split=os.path.splitext(filename)#拆分文件名和扩展名
    # 如果文件名为result.txt,则清空里面的内容,作为结果文件
    # if filename == "result.txt":
    #     f.truncate()

    # 拓展名为txt,注意:不包含.py
    if split[1] == ".txt" and split[1]!=".py" and filename != "result.txt":
        print("文件路径:"+filePath)
        for line in open(filePath,encoding='utf-8', errors='ignore'):
            # print(str(line))
            f.writelines(line)

def openDir(filePath,f):#递归文件夹
    pathDir=os.listdir(filePath)#返回包含的文件或文件夹的名字的列表
    for filename in pathDir:#遍历列表
        childPath=os.path.join(filePath,filename)

        a = os.path.isfile(childPath)

        #判断是否为文件夹
        if os.path.isfile(childPath):
            isFile(childPath,f)
        else:
            openDir(childPath,f)


# rootDir=r'D:\\files\文件夹'
rootDir=os.getcwd()#根目录--工作目录

pathDir =  os.listdir(rootDir)#列出根目录下所有内容

f=open('result.txt','w+',encoding='utf-8')

for allDir in pathDir:#遍历列表
    filepath=os.path.join(rootDir,allDir)#文件路径合成
    aa = os.path.isfile(filepath)
    #判断是否为文件夹
    if os.path.isfile(filepath):
        isFile(filepath,f)
    else:
        openDir(filepath,f)

input("Enter Pass")
