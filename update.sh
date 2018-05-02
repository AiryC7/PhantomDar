#!/bin/bash
rm -r Gaydar

git clone https://github.com/EmberVulpix/Gaydar
cd Gaydar

PS3="Welche Map möchtest du benutzen?? "
options=("4k Map" "8k Map")
select opt in "${options[@]}"
do
    case $opt in
        "4k Map")
            echo "Benutze 4k Map"
            if [ -e src/main/resources/maps/Erangel4k.png ]
            then
              mv src/main/resources/maps/Erangel_Minimap.png src/main/resources/maps/Erangel8k.png
              mv src/main/resources/maps/Miramar_Minimap.png src/main/resources/maps/Miramar8k.png
              mv src/main/resources/maps/Erangel4k.png src/main/resources/maps/Erangel_Minimap.png
              mv src/main/resources/maps/Miramar4k.png src/main/resources/maps/Miramar_Minimap.png
            fi
            break
            ;;
        "8k Map")
            echo "Benutze 8k Map"
            if [ -e src/main/resources/maps/Erangel8k.png ]
            then
              mv src/main/resources/maps/Erangel_Minimap.png src/main/resources/maps/Erangel4k.png
              mv src/main/resources/maps/Miramar_Minimap.png src/main/resources/maps/Miramar4k.png
              mv src/main/resources/maps/Erangel8k.png src/main/resources/maps/Erangel_Minimap.png
              mv src/main/resources/maps/Miramar8k.png src/main/resources/maps/Miramar_Minimap.png
            fi
            break
            ;;
        *) echo invalid option;;
    esac
done

cores=$(nproc)

mvn -T "$cores"C clean verify install

cd ..

if [ -e run.sh ]
then
  echo "Vorherige run.sh behalten? [Y/N]? "
  read keep
  if [ "$keep" != "${keep#[Yy]}" ]
  then
    exit
  fi
fi

wget https://raw.githubusercontent.com/ThePhantom410/PhantomDar/master/create_run.sh -O create_run.sh
chmod +x create_run.sh
./create_run.sh
