<!--
 * @Date: 2021-12-16 14:50:54
 * @LastEditors: Future Meng futuremeng@gmail.com
 * @LastEditTime: 2025-12-18 14:20:59
-->
本项目在garylab/dnmp的基础上扩展了tomcat、minio和jenkins，当garylab/dnmp更新时，通过以下步骤获取更新
1. 查看是否添加了更新源
   ```
   git remote -v
   ```
2. 添加更新源，本项目fork自garylab/dnmp
   ```
   git remote add upstream git@github.com:garylab/dnmp.git
   ```
3. 从源更新
   ```
   git fetch upstream
   ```
4. 合并源的分支
   ```
   git merge upstream/master
   ```

5. 推送到gitee
   ```
   git push gitee
   ```