import os

def isFile(filePath):#修改文件扩展名
    filename=filePath.split('\\')[-1]#拆分文件路径获得文件名
    # 打印文件名
    print("修改前文件名:"+filename)
    fatherPath=filePath.replace(filename,'')#获得父级路径
    split=os.path.splitext(filename)#拆分文件名和扩展名
    # 文件名符合以下条件都修改为.jpg,注意:不包含.py
    if split[1] == ".png" or split[1]==".jpeg" or split[1]==".gif" or split[1]==".bmp" or split[1]==".webp" or split[1]==".tif" or split[1]==".jfif" and split[1]!=".py":
        newname=split[0]+'.jpg'#生成新文件名
        os.chdir(fatherPath)#改变当前工作目录到指定的路径
        os.rename(filename,newname)#文件重命名

def openDir(filePath):#递归文件夹
    pathDir=os.listdir(filePath)#返回包含的文件或文件夹的名字的列表
    for filename in pathDir:#遍历列表
        childPath=os.path.join(filePath,filename)

        a = os.path.isfile(childPath)

        #判断是否为文件夹
        if os.path.isfile(childPath):
            isFile(childPath)
        else:
            openDir(childPath)


# rootDir=r'D:\\files\文件夹'
rootDir=os.getcwd()#根目录--工作目录

pathDir =  os.listdir(rootDir)#列出根目录下所有内容

for allDir in pathDir:#遍历列表
    filepath=os.path.join(rootDir,allDir)#文件路径合成
    aa = os.path.isfile(filepath)
    #判断是否为文件夹
    if os.path.isfile(filepath):
        isFile(filepath)
    else:
        openDir(filepath)

input("Enter Pass")
