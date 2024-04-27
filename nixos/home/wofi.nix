{
  programs.wofi = {
    enable = true;

    style = ''
      window {
        margin: 16px;
        background-color: transparent;
      }

      #input {
        font-family: SpaceMono Nerd Font Mono, Noto Sans;
        font-size: 20px;
        font-weight: bold;
        margin: 16px;
        border: 1px solid black;
        border-radius: 8px;
        background-color: white;
      }

      #inner-box {
        margin: 16px;
        background-color: white;
      }

      #scroll {
        margin: 16px;
        border: 1px solid black;
        border-radius: 8px;
        background-color: white;
      }

      #text {
        font-family: SpaceMono Nerd Font Mono, Noto Sans;
        font-size: 20px;
        font-weight: bold;
        margin: 16px;
        background-color: transparent;
      }
      
      #entry:selected {
        border: 1px solid black;
        border-radius: 8px;
      }
    '';
  };
}
