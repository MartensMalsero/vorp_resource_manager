#!/bin/sh

#path to your git installation
GIT='/cmd/git.exe'

#path to your resources folder -> ATTENTION */ is required at the end of the path!
resources='./server/resources/*/'

#path to your WinRAR installation
WinRAR=''

#path to your workspace where the txData, server and CFX-files folders are also located.
Workspace=''

#path to FXServer.exe in your CFX-files folder
SERVER=''

cfx_data_loaded="0";

function start_main {
    echo
    echo "Please select an option:"
    echo
    echo "1: Install VORP Premade"
    echo "2: Add resource"
    echo "3: Remove resource"
    echo "4: Update resource"
    echo "5: Update resource & start"
    echo "6: Exit"
    echo
    read option

    case $option in
        "1")
            premade_folder_check
            ;;
        "2")
            add_res
            ;;
        "3")
            remove_res
            ;;
        "4")
            update_start false
            ;;
        "5")
            update_start true
            ;;
        "6")
            exit
            ;;
        *)
            echo
            echo "Option not available! Please choose an option from the list."
            echo

            start_main
            ;;
    esac
}

function premade_folder_check {
    if [ $cfx_data_loaded -eq "0" ]; then
        cfx_data_loaded="1";
        cfx_server_data;
    fi

    echo
    echo "Search folders ..."
    echo

    counter_one=0
    counter_two=0
    for dir in $resources; do
        counter_one=$((counter_one+1))
        if [ "$dir" != "$resources" ] && [ $counter_one -gt 6 ]; then
            counter_two=$((counter_two+1))
        fi
    done

    if [ $counter_one -eq 6 ]; then
        counter=0
    elif [ $counter_one -gt 6 ]; then
        counter=counter_one-6
    fi

    if [ "$counter" != "0" ]; then
        for dir in $resources; do
            premade $(basename $dir) $dir;
        done

        start_main;
    else
        cd ${resources/"*/"/""};

        create_folder "[vorp_essentials]";
        create_folder "[vorp_plugins]";
        create_folder "[non_vorp_plugins]";
        create_folder "[syn]";
        create_folder "[DevDokus]";
        create_folder "[ricx]";
        create_folder "[maps]";

        eval cd "$Workspace";

        premade_folder_check;
    fi
}

function premade {
    case $1 in
        "[vorp_essentials]")
            cd $2;

            git_clone https://github.com/VORPCORE/ghmattimysql-oxmysql.git ghmattimysql;
            git_clone https://github.com/VORPCORE/vorp_inputs-lua.git vorp_inputs;
            git_clone https://MartensMalsero@bitbucket.org/new-western-roleplay/vorp_character_build.git vorp_character;
            git_clone https://github.com/VORPCORE/vorp_inventory-lua.git vorp_inventory;
            git_clone https://github.com/VORPCORE/vorp-core-lua.git vorp_core;
            git_clone https://github.com/outsider31000/menuapi.git menuapi;

            eval cd "$Workspace";
            ;;

        "[vorp_plugins]")
            cd $2;
            
            git_clone https://github.com/VORPCORE/vorp_admin.git vorp_admin;
            git_clone https://github.com/VORPCORE/vorp_banking.git vorp_banking;
            git_clone https://github.com/VORPCORE/vorp_barbershop_lua.git vorp_barbershop;
            git_clone https://github.com/VORPCORE/vorp_bossmanager.git vorp_bossmanager;
            git_clone https://github.com/VORPCORE/vorp_clothingstores-lua.git vorp_clothingstore;
            git_clone https://github.com/VORPCORE/vorp_crafting.git vorp_crafting;
            git_clone https://github.com/alphatule/vorp_DeliveryJob.git vorp_DeliveryJob;
            git_clone https://github.com/VORPCORE/vorp_fishing-lua.git vorp_fishing;
            git_clone https://github.com/alphatule/GoldPaning.git vorp_goldpanning;
            git_clone https://MartensMalsero@bitbucket.org/new-western-roleplay/vorp_housing_build.git vorp_housing;
            git_clone https://github.com/VORPCORE/VORP-Hunting.git vorp_hunting;
            git_clone https://github.com/VORPCORE/vorp_lumberjack.git vorp_lumberjack;
            git_clone https://github.com/VORPCORE/vorp_mailbox.git vorp_mailbox;
            git_clone https://github.com/VORPCORE/vorp_mining.git vorp_mining;
            git_clone https://MartensMalsero@bitbucket.org/new-western-roleplay/vorp_ml_policejob_build.git vorp_ml_policejob;
            git_clone https://github.com/EsMapachito/vorp_moonshiner.git vorp_moonshiner;
            git_clone https://github.com/outsider31000/vorp_npcloot.git vorp_npcloot;
            git_clone https://MartensMalsero@bitbucket.org/new-western-roleplay/vorp_postman_build.git vorp_postman;
            git_clone https://github.com/VORPCORE/vorp_progressbar.git vorp_progressbar;
            git_clone https://MartensMalsero@bitbucket.org/new-western-roleplay/vorp_que_build.git vorp_que;
            git_clone https://github.com/VORPCORE/vorp_radius.git vorp_radius;
            git_clone https://MartensMalsero@bitbucket.org/new-western-roleplay/vorp_stables_build.git vorp_stables;
            git_clone https://github.com/VORPCORE/vorp_stores-lua.git vorp_stores;
            git_clone https://github.com/VORPCORE/vorp_traffic.git vorp_traffic;
            git_clone https://github.com/VORPCORE/Vorp_walkanim.git vorp_walkanim;
            git_clone https://github.com/VORPCORE/vorp_weaponsv2.git vorp_weaponsv2;
            git_clone https://github.com/VORPCORE/vorp_zonenotify.git vorp_zonenotify;

            eval cd "$Workspace";
            ;;

        "[non_vorp_plugins]")
            cd $2;

            git_clone https://github.com/BulgaRpl/bulgar_doorlocks_vorp.git bulgar_doorlocks_vorp;

            eval cd "$Workspace";
            ;;

        "[syn]")
            cd $2;

            git_clone https://MartensMalsero@bitbucket.org/new-western-roleplay/syn_bandana_build.git syn_bandana;
            git_clone https://MartensMalsero@bitbucket.org/new-western-roleplay/syn_construction_build.git syn_construction;

            curl https://cdn.discordapp.com/attachments/903875147050655744/943606123016097843/syn_inputs.rar --output syn_inputs.rar;
            unrar syn_inputs.rar;
            
            curl https://cdn.discordapp.com/attachments/777295888543645716/996744924437430352/syn_medical.zip --output syn_medical.zip;
            unrar syn_medical.zip;

            curl https://cdn.discordapp.com/attachments/903875147050655744/906890251312721940/syn_minigame.rar --output syn_minigame.rar;
            unrar syn_minigame.rar;

            git_clone https://MartensMalsero@bitbucket.org/new-western-roleplay/syn_news_build.git syn_news;
            git_clone https://MartensMalsero@bitbucket.org/new-western-roleplay/syn_undertaker_build.git syn_undertaker;

            eval cd "$Workspace";
            ;;

        "[DevDokus]")
            cd $2;

            git_clone https://github.com/DevDokus/RedM-BountyHunter.git RedM_BountyHunter;
            git_clone https://github.com/DevDokus/RedM-Metabolism.git RedM_Metabolism;

            eval cd "$Workspace";
            ;;

        "[ricx]")
            cd $2;

            git_clone https://github.com/zelbeus/ricx_grave_robbery.git ricx_grave_robbery;

            eval cd "$Workspace";
            ;;

        "[maps]")
            cd $2;
            
            git_clone https://MartensMalsero@bitbucket.org/new-western-roleplay/interiors.git interiors;
            git_clone https://MartensMalsero@bitbucket.org/new-western-roleplay/moonshine_interiors.git moonshine_interiors;
            
            curl https://cdn.discordapp.com/attachments/880332218864648202/985206148804263956/redm_mexico_map.zip --output redm_mexico_map.zip;
            unrar redm_mexico_map.zip;

            eval cd "$Workspace";
            ;;
    esac
}

function add_res {
    echo
    echo "Select a head folder where you want to install the resource:"
    echo

    counter=0

    counter=$((counter+1))
    echo "$counter: new folder"
    echo "-------------"

    for dir in $resources; do
        counter=$((counter+1))
        echo "$counter: $(basename $dir)"
    done

    echo
    read option

    counter=1

    if [ "$option" == "1" ]; then
        echo
        echo "Please enter the folder name for the head folder without the brackets []:"
        echo

        read HeadFolderName

        tmp_resourcefolder=${resources/"*/"/""}[$HeadFolderName]

        mkdir $tmp_resourcefolder

        cd $tmp_resourcefolder
    else
        for dir in $resources; do
            counter=$((counter+1))
            if [ "$option" == "$counter" ]; then
                cd $dir
            fi
        done
    fi

    echo
    echo "Do you want to clone a Git repository or download a .zip, .rar, or .7z file?"
    echo "1: Git"
    echo "2: .zip, .rar, .7z"
    echo

    read option

    case $option in
        "1")
            echo
            echo "Please enter the Github URL of the project you want to clone:"
            echo

            read GitURL

            echo
            echo "Please enter the name of the Git folder for the project you want to clone. Default is the default project name."
            echo

            read GitProjectName

            if [ "$GitProjectName" == "" ]; then
                git_clone $GitURL
            else
                git_clone $GitURL $GitProjectName
            fi
            ;;

        "2")
            echo
            echo "Please enter the URL of the file you want to download:"
            echo

            read URL

            echo
            echo "Please enter the file extension. DOT REQUIRED! (.zip, .rar, .7z)"
            echo

            read Extension

            echo
            echo "Please enter the name of the folder for the downloaded file."
            echo

            read FolderName

            curl $URL --output $FolderName$Extension;
            unrar $FolderName$Extension;
            ;;
        esac

    eval cd "$Workspace";

    start_main
}

function remove_res {
    echo
    echo "Select a head folder where you want to delete the resource:"
    echo

    counter=0
    path=""

    counter=$((counter+1))
    echo "$counter: quit"
    echo "-------------"

    for dir in $resources; do
        counter=$((counter+1))
        echo "$counter: $(basename $dir)"
    done

    echo
    read option1

    counter=0
    indir_counter=0

    if [ "$option1" == "1" ]; then
        start_main;
    else
        echo
        echo "Select a resource folder that you want to delete:"
        echo

        counter=$((counter+1))
        echo "$counter: quit"
        echo "-------------"

        for dir in $resources; do

            counter=$((counter+1))
            if [ "$option1" == "$counter" ]; then

                indir_counter=$((indir_counter+1))
                
                resourcedir=${dir/[/"\["};
                resourcedir=${resourcedir/]/"\]"};

                for indir in $resourcedir*/; do
                    indir_counter=$((indir_counter+1))
                    echo "$indir_counter: $(basename $indir)"
                done
            fi
        done

        echo
        read option2
        echo

        counter=1
        indir_counter=0

        for dir in $resources; do

            counter=$((counter+1))
            if [ "$option1" == "$counter" ]; then
                indir_counter=$((indir_counter+1))
                
                resourcedir=${dir/[/"\["};
                resourcedir=${resourcedir/]/"\]"};

                for indir in $resourcedir*/; do
                    indir_counter=$((indir_counter+1))
                    if [ "$option2" == "$indir_counter" ]; then
                        rm -rf $indir;
                        echo "Resource $(basename $indir) successfully deleted"
                    fi
                done
            fi

        done
    fi

    echo
    echo
    
    start_main;
}

function update_start {

    echo "--- Start checking the resources for updates ---"

    for dir in $resources; do
        if [ "$dir" != "$resources" ]; then
            if [ "$(basename $dir)" != "[gamemodes]" ] &&
               [ "$(basename $dir)" != "[gameplay]" ] &&
               [ "$(basename $dir)" != "[local]" ] &&
               [ "$(basename $dir)" != "[managers]" ] &&
               [ "$(basename $dir)" != "[system]" ] &&
               [ "$(basename $dir)" != "[test]" ]; then

                resourcedir=${dir/[/"\["};
                resourcedir=${resourcedir/]/"\]"};
                
                for indir in $resourcedir*/; do
                    if [ "$indir" != "$dir" ] && [ "$indir" != "$resourcedir*/" ]; then
                        echo "Checking $(basename $indir) ..."
                        if [ -d "$indir/.git/" ]; then
                            cd $indir
                            $GIT pull
                            echo
                            eval cd "$Workspace";
                        else
                            echo "No Git repository, skip update check!"
                            echo
                        fi
                    fi
                done
            fi
        fi
    done

    echo "--- Start building resources.cfg ---"

    file="./server/resources.cfg";
    rm $file;

    echo "#######################################################################################" >> $file;
    echo "##################                                               ######################" >> $file;
    echo "##################                V#RP CORE                      ######################" >> $file;
    echo "##################                FRAMEWORK                      ######################" >> $file;
    echo "##################                                               ######################" >> $file;
    echo "#######################################################################################" >> $file;
    echo >> $file;
    echo >> $file;
    echo >> $file;
    echo "# READ THIS  IS IMPORTANT" >> $file;
    echo "#############################################################################################" >> $file;  
    echo "# NOTE: THAT YOU MIGHT NEED TO TRANSLATE SOME SCRIPTS TO YOUR LANGUAGE                      #" >> $file;
    echo "# CHECK FOR EVERY SCRIPT IF THEY HAVE A CONFIG.LUA FILE THATS WHERE YOU CHANGE THINGS       #" >> $file;
    echo "# MAKE SURE TO CHECK FOR ERRORS IN YOUR CONSOLE OR IN GAME  PRESS F8                        #" >> $file;
    echo "#############################################################################################" >> $file;
    echo >> $file;
    echo "ensure mapmanager" >> $file;
    echo "ensure spawnmanager" >> $file;
    echo "ensure sessionmanager-rdr3" >> $file;
    echo "ensure rconlog" >> $file;
    echo "ensure fivem" >> $file;
    echo "ensure chat" >> $file;

    #start with the essential plugins first
    for dir in $resources; do
        if [ "$dir" != "$resources" ] && [ "$(basename $dir)" == "[vorp_essentials]" ]; then
            echo >> $file;
            echo "############### $(basename $dir) ###################" >> $file;
            echo >> $file;

            resourcedir=${dir/[/"\["};
            resourcedir=${resourcedir/]/"\]"};
            
            for indir in $resourcedir*/; do
                if [ "$indir" != "$dir" ] && [ "$indir" != "$resourcedir*/" ] &&
                   [ "$(basename $indir)" == "vorp_core" ]; then
                    echo "ensure $(basename $indir)" >> $file;
                fi
            done

            for indir in $resourcedir*/; do
                if [ "$indir" != "$dir" ] && [ "$indir" != "$resourcedir*/" ] &&
                   [ "$(basename $indir)" != "vorp_core" ]; then
                    echo "ensure $(basename $indir)" >> $file;
                fi
            done
        fi
    done

    #do all other
    for dir in $resources; do
        if [ "$dir" != "$resources" ]; then
            if [ "$(basename $dir)" != "[gamemodes]" ] &&
               [ "$(basename $dir)" != "[gameplay]" ] &&
               [ "$(basename $dir)" != "[local]" ] &&
               [ "$(basename $dir)" != "[managers]" ] &&
               [ "$(basename $dir)" != "[system]" ] &&
               [ "$(basename $dir)" != "[test]" ] &&
               [ "$(basename $dir)" != "[vorp_essentials]" ]; then

                echo >> $file;
                echo "############### $(basename $dir) ###################" >> $file;
                echo >> $file;

                resourcedir=${dir/[/"\["};
                resourcedir=${resourcedir/]/"\]"};
                
                for indir in $resourcedir*/; do
                    if [ "$indir" != "$dir" ] && [ "$indir" != "$resourcedir*/" ]; then
                        echo "ensure $(basename $indir)" >> $file;
                    fi
                done
            fi
        fi
    done

    cat $file;

    if [ "$1" == "true" ]; then
        start /NODE "$SERVER" +set serverProfile "default"
        exit
    fi

    start_main
}

function cfx_server_data {
    eval cd "$Workspace";
    cd 'server'

    git_clone https://github.com/citizenfx/cfx-server-data.git cfx_server_data

    cp -RT 'cfx_server_data/resources' './resources/'
    rm -rf 'cfx_server_data'

    eval cd "$Workspace";
}

function create_folder {
    echo "Create folder $1"
    mkdir "$1";
}

function git_clone {
    echo
    $GIT clone $1 $2;

    if [ ! -z "$3" ]; then
        echo $3
        $GIT checkout $3
    fi
}

function unrar {
    "$WinRAR" x -o+ $1;
    rm $1;
}

start_main;