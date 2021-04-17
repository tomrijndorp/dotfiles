FROM ubuntu:20.04

RUN apt-get update && apt-get install -y sudo git
ARG DUSER=youser
COPY . /home/$DUSER/.dotfiles

RUN \
    useradd $DUSER && \
    usermod -aG sudo $DUSER && \
    usermod -s /bin/zsh $DUSER && \
    echo "$DUSER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$DUSER \
        && chmod 0440 /etc/sudoers.d/$DUSER && \
    chown -R $DUSER:$DUSER /home/$DUSER/

USER $DUSER

RUN \
    ~/.dotfiles/system/bin/dot install all
# sudo -i -u $DUSER bash <<EOF
# set -euxo pipefail
# whoami
# id -u
# groups
# sudo chown -R $DUSER:$DUSER /home/$DUSER/
# ls -la ~/.dotfiles
# EOF