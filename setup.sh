#!/bin/bash
trap 'exit' ERR

DEV=false

while getopts ":d" opt; do
    case $opt in
        d)
            echo "Dev mode"
            DEV=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit
            ;;
    esac
done

if [ -e package.json ]; then

    if [ "$DEV" = true ] ; then
        echo "Installing npm packages..."
        npm install
        npm update
    else
        echo "Installing npm packages with --production flag"
        npm install --production --quiet
    fi

fi

if [ -e Gemfile ]; then
    echo "Installing Ruby gems..."
    bundle install --binstubs --path=vendor/gems
fi

if [ -e bower.json ]; then
    echo "Installing Bower packages..."
    bower update
fi

