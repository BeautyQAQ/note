## 如何把B站缓存m4s文件转换成mp4格式

 找到需要的m4s文件  

![文件位置](https://study-note-huang.oss-cn-beijing.aliyuncs.com/img/20220411223416.png)

**下载ffmpeg工具**

[FFmpeg](https://www.gyan.dev/ffmpeg/builds/) 是一款免费开源的转换音频视频格式的程序工具（已经在百度网盘保存）  

下载解压后，依次点击，进入如下界面  

![ffmpeg](https://study-note-huang.oss-cn-beijing.aliyuncs.com/img/20220411224059.png)

把刚才的audio.m4s文件和video.m4s文件拖到此界面，如图  

![需要合并的文件](https://study-note-huang.oss-cn-beijing.aliyuncs.com/img/20220411224127.png)

在当前文件夹进入powershell，执行如下命令  

```powershell
.\ffmpeg.exe -i video.m4s -i audio.m4s -codec copy Output.mp4
```

执行成功后，生成Output.mp4文件  

![合成成功](https://study-note-huang.oss-cn-beijing.aliyuncs.com/img/20220411224517.png)