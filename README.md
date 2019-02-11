## Welcome to my Computer Vision repository

In this repository you will find documentation and code files for three distinct projects regarding implementation of Computer Vision algorithms using MATLAB. These projects were completed and submitted for credit in a 400 level Computer Vision course at The Pennsylvanina State University. 

### Template Matching

The goal of this project was to implement template matching for the detection of objects in
images. One of the most common tasks in computer vision is object detection; be it cars, faces,
motion capture markers, or in this case airplanes.

Specifically, the goal was to detect airplanes from a satellite view. In this project we were
provided Google Earth images of airplane depots, with the goal of implementing a template
matching based algorithm to detect and count the airplanes in each image.

For a detailed quantitative and qualitative report on the results of this project, please click 
on the "View on GitHub" icon at the top of this screen and navigate to Project 1 > Documentation > EE_454_Project_1.pdf

### Multiview Projection

The goal of this project was to implement forward (3D point to 2D point) and inverse (2D point to
3D ray) camera projection, and to perform triangulation from two cameras to do 3D reconstruction 
from pairs of matching 2D image points.

The specific tasks were to project 3D coordinates (sets of 3D joint locations on a human body,
measured by motion capture equipment) into image pixel coordinates that we could overlay on top 
of an image, to then convert those 2D points back into 3D viewing rays, and then triangulate
the viewing rays of two camera views to recover the original 3D coordinates we started with.

For a detailed quantitative and qualitative report on the results of this project, please click 
on the "View on GitHub" icon at the top of this screen and navigate to Project 2 > Documentation > EE_454_Project_2.pdf

### Motion Detection

The goal of this project was to implement four simple motion detection algorithms, run them on 
short videos, and compare the results. The four algorithms are:
- Simple Background Subtraction
- Simple Frame Differencing
- Adaptive Background Subtraction
- Persistent Frame Differencing

We were required to implement all four in one program and generate, as output, a four-panel frame
showing the results of each algorithm, on each video frame, and generate a video of the results.

For a detailed quantitative and qualitative report on the results of this project, please click 
on the "View on GitHub" icon at the top of this screen and navigate to Project 3 > Documentation > EE_454_Project_3.pdf

### How to use Markdown

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

## Editing

You can use the [editor on GitHub](https://github.com/emmanuelfwerr/Computer-Vision/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
