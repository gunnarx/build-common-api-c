
#for version in v219 v220 v221 v222 v223 v224 v225 v226 ; do
# autotool versions, use older version of script for those
# the build.sh script is now changed to use meson for newer
# systemd

for version in v239 ; do
  echo Running for $version, please wait
  r=SUCCESS
  ./build.sh $version >log.$version.txt 2>&1
  [ $? -ne 0 ] && r=FAILED
  touch $version.$r
done
