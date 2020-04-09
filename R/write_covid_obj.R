#' Write Customized SARS COVID-19 3D Model
#'
#' This function writes out a custom 3D model of the COVID-19 virus, with
#' colors specified by the user. The user can change the color of the main
#' body, the color of the spike protein, and the color of an open spike protein.
#'
#' The base model was sourced from the NIH 3D Print Exchange.
#'
#' @param filename Default `covidcustom.obj`.
#' @param color_membrane Default `#a1cdf0`. Color of the main membrane (lipid layer) of the coronavirus.
#' @param color_spike Default `#3432cf`. Color of the closed spike protein (crown) on the coronavirus.
#' @param color_open_spike Default `#d92bc5`. Color of the open spike protein (crown) on the coronavirus.
#' @return Path to the file.
#' @export
#'
#' @examples
#' library(rayrender)
#' #Write a base version of the model and render it with rayrender, using vertex colors.
#' \donttest{
#'
#' write_covid_obj("defaults.obj")
#'
#' #Render the model:
#' obj_model("defaults.obj", vertex_colors = TRUE) %>%
#'   add_object(sphere(y=10,z=10,x=10, material=light(color="lightblue",intensity=100))) %>%
#'   add_object(sphere(y=10,z=10,x=-10, material=light(color="orange",intensity=100))) %>%
#'   render_scene(parallel=TRUE, samples = 100, fov = 7, min_variance=0, focal_distance = 9.6,
#'                width=800,height=800)
#'
#' #Now write a custom version, recreating the "standard" grey and red COVID-19 visualization.
#'
#' write_covid_obj("standard.obj",
#'                 color_membrane = "#a1cdf0",
#'                 color_spike = "#3432cf",
#'                 color_open_spike = "#d92bc5")
#'
#' #Render the custom model:
#' obj_model("standard.obj", vertex_colors = TRUE) %>%
#'   add_object(sphere(y=10,z=10,x=10, material=light(color="lightblue",intensity=100))) %>%
#'   add_object(sphere(y=10,z=10,x=-10, material=light(color="orange",intensity=100))) %>%
#'   render_scene(parallel=TRUE, samples = 100, fov = 7, min_variance=0, focal_distance = 9.6,
#'                width=800,height=800)
#' }
write_covid_obj = function(filename = "covidcustom.obj",
                           color_membrane = "#a1cdf0",
                           color_spike = "#3432cf",
                           color_open_spike = "#d92bc5") {
  test = readLines(corona_model())
  justnormals = test[(grepl("vn\\s", test,perl=TRUE))]
  justverts = test[(grepl("v\\s", test,perl=TRUE))]
  justfaces = test[(grepl("f\\s", test,perl=TRUE))]

  numverts = lapply(strsplit(justverts,"\\s"),(function(x) as.numeric(x[-1])))
  vertexcolors = do.call(rbind, numverts)[,4:6]

  first_col = c(0.8,0.8,0.8)
  second_col = c(0.624, 0.122, 0.937)
  third_col = c(1,0,0)

  color_membrane = rayrender:::convert_color(color_membrane)
  color_spike = rayrender:::convert_color(color_spike)
  color_open_spike = rayrender:::convert_color(color_open_spike)

  copy_vertex = vertexcolors
  col_index = rep(1,nrow(copy_vertex))
  for(i in 1:nrow(vertexcolors)) {
    if(all(vertexcolors[i,] == first_col)) {
      col_index[i] = 1
      copy_vertex[i,] = color_membrane
    } else if (all(vertexcolors[i,] == second_col)) {
      col_index[i] = 2
      copy_vertex[i,] = color_open_spike
    } else if (all(vertexcolors[i,] == third_col)) {
      col_index[i] = 3
      copy_vertex[i,] = color_spike
    }
  }

  vertexcolorsfinal = do.call(rbind, numverts)
  vertexcolorsfinal[,4:6] = round(copy_vertex,3)

  tempcon = file(filename,"wt")
  on.exit(close(tempcon))
  writeLines(apply(vertexcolorsfinal,1,(function(x) paste(c("v",x),collapse=" "))),tempcon)
  writeLines(justnormals,tempcon)
  writeLines(justfaces,tempcon)
  return(path.expand(filename))
}
