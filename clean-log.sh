for path in `find /users/weijia/cascade/build/src/service/data_path_logic/cnn_classifier_cfg -regex ".*\.plog"`
do
    rm -rf $path
done

for path in `find /users/weijia/cascade/build/src/service/data_path_logic/cnn_classifier_cfg -regex ".*\.log"`
do
    rm -rf $path
done