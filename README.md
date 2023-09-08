# FPGA Sobel Edge Detection Project

This FPGA Sobel Edge Detection project is designed to perform edge detection on an image using the Sobel operator. The project utilizes hardware description language (HDL) and FPGA hardware to accelerate the image processing task. The provided files and directories include:

## Files and Directories

1. **README.md**: This documentation file.

2. **main**: The main directory containing project-related files.

3. **memory_RAM.v**: A Verilog file representing a memory module.

4. **myip_v1_0-1.v**: A Verilog file that appears to be related to the custom IP core used in the project.

5. **original_image.png**: The input image on which Sobel edge detection will be applied.

6. **phase1_group5.py**: A Python script, possibly used for pre-processing or interfacing with the FPGA.

7. **sobel.v**: The Verilog file for implementing the Sobel edge detection algorithm.

8. **tb_myip_v1_0.v**: A Verilog testbench for the custom IP core.

## Project Overview

The project seems to be focused on implementing Sobel edge detection on an FPGA platform. Edge detection is a fundamental image processing technique used to identify edges and boundaries within images. The Sobel operator is commonly used for this purpose due to its simplicity and effectiveness.

## Usage

To use this project, you would typically perform the following steps:

1. Load the provided Verilog files, especially `sobel.v` and `memory_RAM.v`, onto your FPGA development board.

2. Interface the FPGA with an image source, possibly using the `phase1_group5.py` script to load and manage the input image.

3. Execute the FPGA design, which will apply the Sobel edge detection algorithm to the input image.

4. Retrieve the processed image or visualize the results as needed.

## Project Team

This project is created and maintained by Team 05 for a specific phase or group project. Please refer to the project team's documentation or contact them directly for more information about the project's goals, progress, and specific details.

## License

The licensing details for this project are not provided in this README. Please check the project files or contact the project team for information regarding the project's licensing terms.

## Additional Information

For more detailed instructions, code explanations, and FPGA setup details, please refer to the specific files within the project directory, and consult the project team for any additional documentation or support.
