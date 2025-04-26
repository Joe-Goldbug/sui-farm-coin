import React from "react";
import { ConnectButton } from "@mysten/dapp-kit";
import { useTheme } from "../../providers/theme/ThemeContext";


const NavBar: React.FC = () => {
  const { darkMode, toggleDarkMode } = useTheme(); 
  return (
    <nav className="bg-transparent p-4 shadow-md w-full">
      <div className="flex justify-end items-center space-x-4">
        <button
          onClick={toggleDarkMode}
                    className="p-2 rounded-md text-white
                    bg-gray-700 hover:bg-gray-600
                    focus:outline-none focus:ring-2
                    focus:ring-offset-2
                    focus:ring-offset-gray-800
                    focus:ring-white"
                    aria-label="Toggle dark mode"
                  >
                    {darkMode ?(
                      <span>🌞 Light</span>
                    ) : (
                      <span>🌛 Dark</span>
                    )}
                  </button>
                  <ConnectButton />
                </div>
              </nav>
  );
};

export default NavBar;
