<!--
 * @Date: 2021-12-16 14:50:54
 * @LastEditors: be_loving@163.com 
 * @LastEditTime: 2023-11-02 13:20:38
-->
本项目在yeszao/dnmp的基础上扩展了tomcat、minio和jenkins，当yeszao/dnmp更新时，通过以下步骤获取更新
1. 查看是否添加了更新源
   ```
   git remote -v
   ```
2. 添加更新源，本项目fork自yeszao/dnmp
   ```
   git remote add upstream git@github.com:yeszao/dnmp.git
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