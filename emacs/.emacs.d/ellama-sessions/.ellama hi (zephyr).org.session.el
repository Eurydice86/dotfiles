#s(ellama-session "ellama hi (zephyr)" #s(llm-ollama nil nil nil "http" "localhost" 11434 "zephyr" "zephyr") "/home/nikos/dotfiles/emacs/.emacs.d/ellama-sessions/ellama hi (zephyr).org" #s(llm-chat-prompt nil nil (#s(llm-chat-prompt-interaction user "hi" nil) #s(llm-chat-prompt-interaction assistant "Hello, how may I assist you today? Please let me know what you'd like to know or help you with. You can ask any question related to various subjects such as science, history, maths, literature or anything else you might be curious about! Just type your query and I'll do my best to provide an accurate and helpful answer. Is there a specific topic you have in mind, or would you like some general knowledge trivia? Let's learn something new together!" nil) #s(llm-chat-prompt-interaction user "how to autostart ollama in archlinux on boot" nil) #s(llm-chat-prompt-interaction assistant "To autostart OllaMA on boot in Arch Linux, follow these steps:

1. Open the terminal and create a new file for the OllaMA service using the `nano` editor:

   ```sh
   sudo nano /etc/systemd/user/ollama.service
   ```

2. Copy the following content into the new file and replace `user` with your own username:

   ```sh
   [Unit]
   Description=OllaMA - An open source language learning assistant
   Requires=user-session@.service
   After=multi-user.target user-session@.service

   [Service]
   Type=simple
   User=%u
   WorkingDirectory=/home/%u
   ExecStart=ollama --database /var/lib/ollama --auth %h
   Restart=always

   [Install]
   WantedBy=user-session@.service
   ```

3. Save the changes and exit the editor (`Ctrl+X`, `Y`, `Enter`)

4. Enable the service to start on boot:

   ```sh
   sudo systemctl --user enable ollama
   ```

5. Start the service for your current user session:

   ```sh
   ollaama &
   ```

6. Verify that the service is running using the `systemctl --user status` command. If the service is running, you should see output similar to this:

   ```sh
   ollama.service - OllaMA - An open source language learning assistant
       Loaded: loaded (/etc/systemd/user/ollama.service; user)
       Active: active (running) since Tue 2021-05-25 09:53:26 CEST; 7s ago
        Docs: https://www.ollamai.com
   ```

That's it! Now, OllaMA should be started automatically on boot and you can use it by launching the `ollama` command in any new terminal window. Enjoy learning a new language with OllaMA!" nil)) nil nil nil nil nil) nil)