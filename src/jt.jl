module jt

export load, load_uniform_grid, load_amr_grids, load_particles, CutRegion
export YTArray, YTQuantity, in_units, in_cgs, get_array, Disk, Ray, Boolean
export Slice, Grids, Sphere, AllData, Projection, GridCollection, CoveringGrid
export physical_constants, units, to_frb, get_smallest_dx, print_stats, CuttingPlane
export SlicePlot, ProjectionPlot, PhasePlot, ProfilePlot, show_plot, save_plot, call
export FixedResolutionBuffer, Profile1D, Profile2D, Profile2D, add_fields, cut_region

using PyCall
@pyimport yt.mods as ytmods
@pyimport yt

include("utils.jl")
include("yt_array.jl")
include("images.jl")
include("data_objects.jl")
include("physical_constants.jl")
include("units.jl")
include("plots.jl")
include("profiles.jl")

import .yt_array: YTArray, YTQuantity, in_units, in_cgs, get_array
import .data_objects: DataSet, Grids, Sphere, AllData, Projection, Slice,
    GridCollection, CoveringGrid, to_frb, print_stats, get_smallest_dx,
    Disk, Ray, Boolean, CuttingPlane, CutRegion, cut_region
import .plots: SlicePlot, ProjectionPlot, PhasePlot, ProfilePlot, show_plot,
    save_plot, call
import .images: FixedResolutionBuffer
import .profiles: Profile1D, Profile2D, Profile3D, add_fields

function load(fn::String; args...)
    ds = ytmods.load(fn; args...)
    return DataSet(ds)
end

# Stream datasets

function load_uniform_grid(data::Dict, domain_dimensions::Array; args...)
    ds = ytmods.load_uniform_grid(data, domain_dimensions; args...)
    return DataSet(ds)
end

function load_amr_grids(data::Dict, domain_dimensions::Array; args...)
    ds = ytmods.load_amr_grids(data, domain_dimensions; args...)
    return DataSet(ds)
end

function load_particles(data::Dict; args...)
    ds = ytmods.load_particles(data; args...)
    return DataSet(ds)
end

end
